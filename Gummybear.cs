using UnityEngine;

public class Gummybear : MonoBehaviour
{
    //Definiera variabler 
    public float SpringConstant = 45f;
    public float DampingConstant = 1.2f;
    public float elasticCoeff = 0.3f;

    private Vector3[] Acceleration;
    private Vector3[] Velocity;
    private Vector3[] Mass;
    private Vector3 Grav = Physics.gravity;

    private int[,] FaceIndex; //Två dimensioners array 
    private int numOfMasses = 8;

    private BoxCollider TriggerCollider;
    private Vector3 force = Physics.gravity;

    //Används för detekterande av kollision 
    Rigidbody Rb;

    // Awake körs när programmet startar. 
    private void Awake()

    {
        //Skapa våran Collider
        TriggerCollider = GetComponent<BoxCollider>();

        //Skapa utrymme i arrayer
        Acceleration = new Vector3[8];
        Velocity = new Vector3[8];
        Mass = new Vector3[8];

        //Front face
        Mass[0] = transform.TransformPoint(new Vector3(-1f, -1f, 1f));
        Mass[1] = transform.TransformPoint(new Vector3(1f, -1f, 1f));
        Mass[2] = transform.TransformPoint(new Vector3(1f, 1f, 1f));
        Mass[3] = transform.TransformPoint(new Vector3(-1f, 1f, 1f));

        // Back face
        Mass[4] = transform.TransformPoint(new Vector3(-1f, -1f, -1f));
        Mass[5] = transform.TransformPoint(new Vector3(-1f, 1f, -1f));
        Mass[6] = transform.TransformPoint(new Vector3(1f, 1f, -1f));
        Mass[7] = transform.TransformPoint(new Vector3(1f, -1f, -1f));


        //Varje sida har fyra massor. Det finns sex sidor.
        FaceIndex =
                new int[6, 4]
                    { 
                        //Front
                        {0, 1, 2, 3}, 

                        //Back
                        {4, 5, 6, 7}, 

                        //Top
                        {5, 3, 2, 6}, 

                        //Bottom
                        {4, 7, 1, 0},

                        //Right
                        {7, 6, 2, 1}, 

                        //Left
                        {4, 0, 3, 5}
                     };
    }


    private void OnTriggerStay(Collider col)
    {
        //Friktion som skalar ner hastigheten på objektet. 
        elasticCoeff *= 0.65f;

        for (int i = 0; i < numOfMasses; i++)
        {
            //Kollisionspunkt
            Vector3 pos = Mass[i];

            //Om kollision studsa upp
            if (col.bounds.Contains(pos))
            {
                pos = transform.InverseTransformPoint(pos);
                Velocity[i] = -Physics.gravity * elasticCoeff;

                if (elasticCoeff < 0.03f)
                {
                    Grav = Vector3.zero;
                }
            }

        }
    }

    //Räkna ut bland annat acceleration 
    private void CalcAcc()
    {
        int m = 1;
        int numFaces = 6;
        int MassPerFace = 4;
        int springLengthRest = 2; // Skillnaden mellan 1 och -1  = 2 
        for (int i = 0; i < numFaces; i++)
        {
            for (int j = 0; j < MassPerFace; j++)
            {
                // Index 0 och index 1 för kuben. Index 1 har skiftat en plats på index i varje face
                int Index0 = FaceIndex[i, j];
                int Index1 = FaceIndex[i, (j + 1) % MassPerFace]; // resten är 1, 2, 3, 0

                //Räknar ut spring force 
                Vector3 PositionDiff = Mass[Index1] - Mass[Index0];
                float springLength = PositionDiff.magnitude;
                float x = springLength - springLengthRest;
                Vector3 diffVel = Velocity[Index1] - Velocity[Index0];
                PositionDiff = PositionDiff / springLength;

                Vector3 Fk = (SpringConstant * x * PositionDiff); // Fk = k x  Hookes lag
                Vector3 Fb = (DampingConstant * diffVel);  // b*F = Fb
                Vector3 SumForce = Fk + Fb;

                Acceleration[Index0] = Acceleration[Index0] + SumForce / m;
                Acceleration[Index1] = Acceleration[Index1] - SumForce / m;
            }
        }
    }


    //Producerar hastigheter och positioner för massorna
    private void Euler()
    {
        Bounds constraints = new Bounds();
        for (int i = 0; i < numOfMasses; i++)
        {
            //euler 
            Velocity[i] = Velocity[i] + Acceleration[i] * Time.deltaTime;
            Mass[i] = Mass[i] + Velocity[i] * Time.deltaTime;

            switch (i)
            {
                case 0:  // förhindrar krasch av programmet 
                    {
                        constraints = new Bounds(Mass[i], Vector3.zero);
                    }
                    break;

                default:
                    {
                        constraints.Encapsulate(Mass[i]);
                    }
                    break;
            }
        }

        //Vi placerar björnen i kuben och får den att följa med i kubens rörelser
        transform.position = constraints.center;
        transform.localScale = constraints.size;
    }


    //Uppdaterar postitionen för kuben varje frame 
    void FixedUpdate()
    {
        int i = 0;
        while (i < numOfMasses)
        {
            Acceleration[i] = Grav; //gravitationskraften
            i++;
        }

        CalcAcc();
        Euler();
    }

}
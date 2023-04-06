using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GemSpawner : MonoBehaviour {
    // Start is called before the first frame update

    public GameObject[] prefabs;
    void Start() {
        StartCoroutine(SpawnGems());
    }

    // Update is called once per frame
    void Update() {
        
    }

    IEnumerator SpawnGems() {
        while(true) {
            if (Random.Range(1, 6) == 1) {
                Instantiate(prefabs[Random.Range(0, prefabs.Length)], new Vector3(26, Random.Range(-10, 10), 10), Quaternion.identity);
            }

            yield return new WaitForSeconds(Random.Range(1, 5));
        }
    }
}

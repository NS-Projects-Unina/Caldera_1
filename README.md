# Adversary Emulation: Lateral Movement

## 1. Sintesi
Questo progetto riguarda la simulazione di uno **scenario adversarial** automatizzato con il framework **MITRE Caldera**, utilizzando il **Movimento Laterale (Lateral Movement)** in ambienti Windows, utilizzando 3 macchine virtuali (1 Kali Linux "attaccante" e 2 Windows 10).
L'obiettivo è dimostrare, in una versione semplificata, la tecnica di attacco **TA0008** di MITRE ATT&CK. Oltre all'uso di MITRE Caldera, abbiamo analizzato la risposta di **Microsoft Defender Antivirus** e accennato a ulteriori possibili tecniche di difesa.

## 2. Topologia di rete e architettura
Nella prima parte della sezione "Strumenti" dell'elaborato, abbiamo esplorato come è strutturato l'ambiente di laboratorio, isolato e costituito da tre nodi:
* **Attaccante / Server MITRE Caldera (Kali Linux):** Ospita il framework di Command & Control (Caldera) e il server listener (Porta 8888).
    * IP: `192.168.56.103`
* **Host A (Windows - Pivot):** Macchina compromessa iniziale. Esegue i comandi di post-exploitation.
    * IP: `192.168.56.106`
* **Host B (Windows - Victim):** Target del movimento laterale.
    * IP: `192.168.56.105`

## 3. Strumenti utilizzati
Nella seconda parte della sezione "Strumenti" dell'elaborato, abbiamo presentato sinteticamente MITRE Caldera ed abbiamo mostrato la configurazione critica dei due host Windows, utilizzando **RPC**, **SMB** (per il file sharing), **WMI** e **WinRM** ed evidenziando il problema del **Credential Reuse** (ovvero l'utilizzo di stesse password, in tal caso, sui diversi host di una rete locale).

## 4. Attacco
Dopo la parte di analisi, si passa alla catena d'attacco, in cui vengono utilizzate diverse abilità, tra cui l'abilità **System Network Connections Discovery** fornita da MITRE Caldera e 3 abilità da noi modificate per i nostri scopi, tra cui **Lateral Movement - Certutil**, su cui spendiamo un maggiore focus nella sezione "Attacco". In quest'ultima, viene anche menzionato il comportamento di Microsoft Defender Antivirus sull'Host B, mentre nella sezione "Difesa" vi sono cenni su possibili contromisure di sicurezza.

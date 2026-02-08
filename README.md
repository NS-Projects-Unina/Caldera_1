# Adversary Emulation: Lateral Movement & Defense Analysis

## 1. Project Overview
Questo progetto analizza le meccaniche del **Movimento Laterale (Lateral Movement)** in ambienti Windows Workgroup, focalizzandosi sullo sfruttamento di credenziali amministrative locali duplicate (*Credential Reuse*) e tecniche *Living off the Land* (LotL).
L'obiettivo è dimostrare la catena di attacco **T1021 (SMB/WinRM)** e analizzare la risposta comportamentale di **Microsoft Defender Antivirus** (Cloud-Delivered Protection).

## 2. Network Topology & Architecture
L'ambiente di laboratorio è isolato e costituito da tre nodi logici:

* **Attacker / C2 Server (Linux):** Ospita il framework di Command & Control (Caldera) e il server listener (Porta 8888).
    * IP: `192.168.56.103`
* **Host A (Windows - Pivot):** Macchina compromessa iniziale. Esegue i comandi di post-exploitation.
* **Host B (Windows - Victim):** Target del movimento laterale.
    * IP: `192.168.56.105`

## 3. Configuration Prerequisites (Vulnerable State)
Affinché la simulazione abbia successo, i target sono stati configurati emulando una *misconfiguration* critica di sicurezza:

1.  **Credential Reuse:** Account `victima` con password identica su Host A e Host B.
2.  **UAC Remote Restriction Bypass:**
    * **Registry Key:** `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`
    * **Value:** `LocalAccountTokenFilterPolicy = 1` (DWORD)
    * **Scopo:** Consentire privilegi amministrativi completi (High Integrity Token) tramite logon di rete locale.
3.  **Network Surface:**
    * **SMB (TCP 445):** Aperto (File Sharing).
    * **WinRM (TCP 5985):** Attivo (`Enable-PSRemoting`).

## 4. Attack Kill Chain (MITRE ATT&CK Mapping)

### Phase 1: Ingress Tool Transfer (T1105) & Deobfuscation (T1140)
L'agente (`splunkd.exe`) viene trasferito e mascherato o codificato localmente per evadere le firme statiche.

```powershell
# Encoding del payload su Host A
certutil -encode splunkd.exe com.crt

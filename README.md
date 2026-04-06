# 🚀 NPU RTL Design: From Compiler to Hardware
모델 경량화(Quantization) 및 컴파일러 스케줄링 지식을 RTL(Register Transfer Level)로 구현하여, 저전력·고효율 AI 가속기 아키텍처를 설계하는 프로젝트입니다.

---

## 🏗️ Project Architecture & Strategy
소프트웨어 계층(Python/PyTorch)의 연산 로직이 실제 실리콘 레벨에서 어떻게 물리적으로 구현되는지 탐구합니다.
- **Goal:** Quantization-Aware Hardware 설계 및 Dataflow 최적화
- **Environment:** Verilog HDL, Icarus Verilog, GTKWave, GitHub Codespaces

---

## 🟢 Step 1: Combinational Logic & Data Routing
NPU 내에서 데이터의 흐름을 제어하고 연산 자원을 할당하기 위한 기초 조합 회로를 설계했습니다.

### 1. 주요 모듈
- **Mux 2-to-1:** 컴파일러의 데이터 경로 제어 로직을 하드웨어로 구현.
- **Priority Encoder (4-to-2):** 여러 연산 유닛의 요청을 하드웨어 레벨에서 우선순위에 따라 즉시 중재.

### 2. 시뮬레이션 결과
![Step 1 Waveform](./images/step1_waveform.png)
- 입력 신호 변화에 따른 출력의 즉각적인 전이(Transition)를 확인하여 조합 회로의 특성을 검증했습니다.

---

## 🔵 Step 2: Sequential Logic & Timing Synchronization
조합 회로에 '시간(Clock)' 개념을 도입하여 데이터를 저장하고 흐름을 제어하는 순차 회로를 설계했습니다.

### 1. 주요 모듈
- **D-FlipFlop (D-FF):** 클럭의 상승 에지(Rising Edge)에서 데이터를 샘플링하여 유지하는 최소 기억 소자.
- **Insight:** 컴파일러가 계산하는 **'1-Cycle Latency'**가 물리적으로 발생하는 지점을 이해하고 동기화 로직을 구축했습니다.

### 2. 시뮬레이션 결과
![Step 2 Waveform](./images/step2_waveform.png)
- 입력 `d`가 변하더라도 `q`는 반드시 `clk` 박자에 맞춰 업데이트되는 동기식 동작을 확인했습니다.

---

## 🟣 Step 3: 8-bit Register & Data Persistence
1-bit D-FF을 확장하여 NPU의 가중치(Weight)나 연산 결과값을 저장할 수 있는 8-bit 레지스터를 설계했습니다.

### 1. 주요 기능 및 모듈
- **8-bit Register with Load Enable:**
  - **Load Signal:** 단순 저장 기능을 넘어, 제어 신호(`load`)가 활성화된 시점에만 데이터를 갱신합니다.
  - **Data Retention:** `load`가 비활성화 상태일 때는 클럭이 유입되어도 기존 데이터를 유지(Hold)합니다.
- **Insight:** 하드웨어가 명령(Instruction)에 따라 특정 시점에만 데이터를 업데이트하는 제어 논리를 이해했습니다.

### 2. 시뮬레이션 결과
![Step 3 Waveform](./images/step3_waveform.png)
- `load=1` 구간에서는 데이터가 클럭 에지에 맞춰 동기화되어 저장되는 것을 확인했습니다.
- `load=0` 구간에서는 입력 데이터가 변경되어도 출력값이 유지되는 **기억 소자(Memory Element)**의 동작을 검증했습니다.
## 🛠️ Upcoming Milestones
- [ ] **Step 4:** Simple FSM (명령어 제어 로직 기초)

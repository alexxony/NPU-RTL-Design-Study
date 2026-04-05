# 🚀 NPU RTL Design: From Compiler to Hardware
모델 경량화(Quantization) 및 컴파일러 스케줄링 지식을 RTL(Register Transfer Level)로 구현하여, 저전력·고효율 AI 가속기 아키텍처를 설계하는 프로젝트입니다.

---

## 🏗️ Project Architecture & Strategy
본 프로젝트는 소프트웨어 계층(Python/PyTorch)에서 정의된 연산 로직이 실제 실리콘 레벨에서 어떻게 물리적으로 구현되는지 탐구합니다.
- **Goal:** Quantization-Aware Hardware 설계 및 Dataflow 최적화
- **Environment:** Verilog HDL, Icarus Verilog, GTKWave, GitHub Codespaces

---

## 🟢 Step 1: Combinational Logic & Data Routing
NPU 내에서 데이터의 흐름을 제어하고, 연산 자원을 효율적으로 할당하기 위한 기초 조합 회로를 설계했습니다.

### 1. 8-bit Saturation Adder
- **Concept:** 8-bit Quantized 모델 인퍼런스 시 발생하는 Overflow 문제를 해결하기 위한 로직입니다.
- **Implementation:** 연산 결과가 `8'hFF(255)`를 초과할 경우, Wrap-around 시키지 않고 최대값에 고정(Clamping)하여 모델의 정확도 손실을 방지합니다.

### 2. Multi-channel Mux (Data Path Selector)
- **Concept:** 컴파일러가 결정한 스케줄링에 따라 특정 연산 유닛(PE)으로 데이터를 라우팅합니다.
- **Insight:** 하드웨어의 고정된 데이터 패스를 소프트웨어(Compiler)가 어떻게 제어하는지 이해하는 기초가 됩니다.

### 3. 4-to-2 Priority Encoder (Hardware Scheduler)
- **Concept:** 여러 연산 유닛에서 동시에 발생하는 요청(Interrupt/Request)을 하드웨어 레벨에서 즉시 중재합니다.
- **Insight:** 소프트웨어 스케줄러의 부하를 줄이고, 실시간 응답성을 보장하기 위한 하드웨어 중재 로직입니다.

---

## 📊 Simulation & Verification
Icarus Verilog를 이용해 설계된 로직의 타이밍 동작을 검증했습니다.

### Waveform Analysis
![Step 1 Waveform](./images/step1_waveform.png)

- **Propagation Delay Check:** 입력 신호(`sel`, `req`) 변화에 따른 출력의 즉각적인 전이(Transition)를 확인했습니다.
- **Corner Case Test:** `req` 신호의 다중 비트 활성화 시 우선순위에 따른 정확한 인코딩 여부를 검증했습니다.
- **Unknown State (x) Handling:** 초기화되지 않은 신호가 시스템에 미치는 영향을 파형으로 분석하고 초기값 설정의 중요성을 체득했습니다.

---

## 🛠️ Upcoming Milestones
- [ ] **Step 2:** Sequential Logic - 클럭(Clock) 도입 및 Latency 제어 (D-FF, Register)
- [ ] **Step 3:** Quantized Multiplier - Fixed-point Scaling 및 Rounding 로직 구현
- [ ] **Step 4:** PE(Processing Element) Array - 시스톨릭 어레이 구조 설계
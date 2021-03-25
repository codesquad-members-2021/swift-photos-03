# [Downey / Isaac] PhotosApp step3 - GCD 활용, Image 저장



![description](https://user-images.githubusercontent.com/62657991/112451076-6d1b8e80-8d98-11eb-8ccf-3b9ffb41e0bc.gif)

- [x] NavigationBar에 좌측 바버튼을 `+`버튼을 추가한다.
- [x] `https://public.codesquad.kr/jk/doodle.json` 주소 JSON 파일을 맥에 다운로드 받고, Xcode 프로젝트에 추가한다.
- [x] Bundle에서 doodle.json 파일을 읽어와서 스위프트 데이터 구조로 변환한다.
- [x] GCD 큐를 활용해서 동시에 최대한 효율적으로 여러 이미지를 다운로드 받아서 표시한다.
- [x] `+`(add) 버튼을 누르면 Modal로 CollectionViewController에서 상속받은 새로운 DoodleViewController를 표시한다.
- [x] CollectionView 배경색을 어두운 회색으로 지정하고, Title을 명시한다
- [x] `Close` 역할을 하는 Right-BarButton 을 ViewDidLoad() 에서 코드로 생성해서 설정한다.
- [x] `Close`버튼을 누르면 dismiss한다.
- [x] 셀 크기는 110 x 50 크기로 지정한다.
- [x] 셀에는 앞 단계와 마찬가지로 UIImageView를 추가하고 커스텀 셀 클래스를 만들어서 연결한다.
- [x] DataSource 프로토콜에서는 모델 객체에 개수와 indexPath에 맞는 데이터 객체를 받아와서 `image`항목에 있는 이미지를 셀에 표시한다.
- [x] 이미지를 전부 다운로드할 때까지 기다리지않고, 버튼을 누르는 즉시 ViewController 화면을 보여준다.
- [x] DoodleViewController 에서 특정 셀을 롱클릭하면 실행화면처럼 Save 액션을 하는 UIMenuItem을 표시한다.



### 학습 키워드

- `DispatchQueue`
- `UITapGestureRecognizer`
- `UIMenuItem`
- `UINavigationController`
- `PHPhotoLibraryChangeObserver`



### 고민과 해결

- `UIMenuItem` 에서 action을 할 때 `@objc func save()` 로 image를 넘기는게 막연했습니다. `@objc` 메소드로 매개변수를 보내는게 마땅치 않아 싱글턴으로 clipboard 역할을 하는 변수를 만들어 image 를 전달하도록 했습니다.



### 질문거리

-  `DataSource` 를 `ViewModel` 혹은 `presenter` 역할 하는 것을 목표로 나누는 것을 시작했습니다. 해당 부분에 대해 어색한 부분이 없지 않은지 궁금합니다.



### 이후 계획

- 피드백 받기 전 서로 모르겠는 코드를 각자 스터디하고 공유한 뒤 피드백 반영 후 다음 스텝 진행할 계획입니다.
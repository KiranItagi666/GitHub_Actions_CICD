# .github/workflows/imagepush.yml
name: Docker Image Build and Push

on:
  workflow_call:

jobs:
  image_push:
    runs-on: java_build
    env:
      DOCKER_IMAGE: kviondocker/petapp:${{ github.sha }}

    steps:
      - name: Check out code
        uses: actions/checkout@v3

      - name: Download built JAR
        uses: actions/download-artifact@v3
        with:
          name: petclinic-jar
          path: target/

      - name: Build Docker Image
        run: |
          sudo docker build -t ${{ env.DOCKER_IMAGE }} .

      - name: Log in to DockerHub
        run: echo "${{ secrets.DOCKER_PASSWORD }}" \
                | sudo docker login -u "${{ secrets.DOCKER_USERNAME }}" --password-stdin

      - name: Push Docker Image
        run: sudo docker push ${{ env.DOCKER_IMAGE }}

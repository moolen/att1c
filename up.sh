#!/bin/bash

kind create cluster --name test
kind export kubeconfig --name test

flux bootstrap github \
    --owner=moolen \
    --repository=att1c \
    --branch=master \
    --private=false \
    --personal \
    --path=clusters/dev
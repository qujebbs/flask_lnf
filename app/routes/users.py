from flask import Flask, render_template, request, redirect, url_for, request, session
import bcrypt
import os
import secrets
import smtplib
from email.mime.text import MIMEText
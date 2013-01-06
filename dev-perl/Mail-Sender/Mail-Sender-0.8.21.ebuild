# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Sender/Mail-Sender-0.8.21.ebuild,v 1.3 2012/12/06 18:18:59 ago Exp $

EAPI=4

MODULE_AUTHOR=JENDA
MODULE_VERSION=0.8.21
inherit perl-module

DESCRIPTION="Module for sending mails with attachments through an SMTP server"

LICENSE="Mail-Sender"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="virtual/perl-MIME-Base64"
DEPEND="${RDEPEND}"

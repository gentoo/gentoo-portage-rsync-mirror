# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/NetxAP/NetxAP-0.20.0.ebuild,v 1.2 2014/08/05 17:44:43 zlogene Exp $

EAPI=4

MODULE_AUTHOR=KJOHNSON
MODULE_VERSION=0.02
inherit perl-module

DESCRIPTION="A base class for protocols such as IMAP, ACAP, IMSP, and ICAP"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/perl-MIME-Base64
	dev-perl/MD5
	virtual/perl-Digest-MD5"
DEPEND="${RDEPEND}"

SRC_TEST=""

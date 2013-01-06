# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/LWP-Authen-Wsse/LWP-Authen-Wsse-0.50.0.ebuild,v 1.3 2012/04/13 09:16:13 ago Exp $

EAPI=4

MODULE_AUTHOR=AUTRIJUS
MODULE_VERSION=0.05
inherit perl-module

DESCRIPTION="Library for enabling X-WSSE authentication in LWP"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="virtual/perl-MIME-Base64
	dev-perl/Digest-SHA1"
DEPEND="${RDEPEND}"

SRC_TEST=do

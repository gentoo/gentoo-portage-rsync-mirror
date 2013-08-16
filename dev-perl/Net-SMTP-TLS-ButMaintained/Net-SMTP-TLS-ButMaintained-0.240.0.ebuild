# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SMTP-TLS-ButMaintained/Net-SMTP-TLS-ButMaintained-0.240.0.ebuild,v 1.1 2013/08/16 08:35:26 patrick Exp $

EAPI=4

MODULE_AUTHOR=FAYLAND
MODULE_VERSION=0.24
inherit perl-module

DESCRIPTION="An SMTP client supporting TLS and AUTH"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	virtual/perl-IO
	virtual/perl-libnet
	>=dev-perl/IO-Socket-SSL-1.760.0
	dev-perl/Net-SSLeay
	virtual/perl-MIME-Base64
	dev-perl/Digest-HMAC
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.300.0
"

SRC_TEST=do

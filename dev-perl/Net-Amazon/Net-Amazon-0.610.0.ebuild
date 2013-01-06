# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Amazon/Net-Amazon-0.610.0.ebuild,v 1.3 2012/04/05 05:05:52 jdhore Exp $

EAPI=4

MODULE_AUTHOR=BOUMENOT
MODULE_VERSION=0.61
inherit perl-module

DESCRIPTION="Net::Amazon - Framework for accessing amazon.com via SOAP and XML/HTTP"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-perl/libwww-perl
	>=dev-perl/XML-Simple-2.08
	>=virtual/perl-Time-HiRes-1.0
	>=dev-perl/Log-Log4perl-0.3
	virtual/perl-Digest-SHA
	dev-perl/URI"
RDEPEND="${DEPEND}"

SRC_TEST="do"

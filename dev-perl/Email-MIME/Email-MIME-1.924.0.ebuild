# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-MIME/Email-MIME-1.924.0.ebuild,v 1.3 2014/03/19 20:49:26 zlogene Exp $

EAPI=5

MODULE_AUTHOR=RJBS
MODULE_VERSION=1.924
inherit perl-module

DESCRIPTION="Easy MIME message parsing"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~sparc-solaris ~x86-solaris"
IUSE="test"

RDEPEND="
	dev-perl/Email-MessageID
	>=dev-perl/Email-MIME-Encodings-1.314.0
	>=dev-perl/Email-MIME-ContentType-1.16.0
	>=dev-perl/Email-Simple-2.102.0
	>=dev-perl/MIME-Types-1.180.0
	!dev-perl/Email-MIME-Modifier
	!dev-perl/Email-MIME-Creator
"
DEPEND="${RDEPEND}
	test? (
		>=virtual/perl-Test-Simple-0.880.0
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST="do"

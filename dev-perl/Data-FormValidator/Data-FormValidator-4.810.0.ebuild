# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-FormValidator/Data-FormValidator-4.810.0.ebuild,v 1.3 2014/07/25 17:21:41 zlogene Exp $

EAPI=5

MODULE_AUTHOR=MARKSTOS
MODULE_VERSION=4.81
inherit perl-module

DESCRIPTION="Validates user input (usually from an HTML form) based on input profile"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="dev-perl/ImageSize
	>=dev-perl/Date-Calc-5.0
	>=dev-perl/File-MMagic-1.17
	>=dev-perl/MIME-Types-1.005
	dev-perl/regexp-common
	>=dev-perl/Perl6-Junction-1.10
	dev-perl/Email-Valid"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do

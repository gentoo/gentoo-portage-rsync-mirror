# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/TextToHTML/TextToHTML-2.520.100-r1.ebuild,v 1.1 2014/08/26 18:35:24 axs Exp $

EAPI=5

MY_PN=txt2html
MODULE_AUTHOR=RUBYKAT
MODULE_VERSION=2.5201
inherit perl-module

DESCRIPTION="HTML::TextToHTML - convert plain text file to HTML"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/YAML-Syck
	virtual/perl-Getopt-Long
	dev-perl/Getopt-ArgvFile"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"

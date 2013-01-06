# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/CGI/CGI-3.510.ebuild,v 1.6 2011/01/22 11:04:07 armin76 Exp $

EAPI=3

MY_PN=${PN}.pm
MODULE_AUTHOR=MARKSTOS
MODULE_VERSION=3.51
inherit perl-module

DESCRIPTION="Simple Common Gateway Interface Class"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

#DEPEND="dev-lang/perl"
#	dev-perl/FCGI" #236921

SRC_TEST="do"

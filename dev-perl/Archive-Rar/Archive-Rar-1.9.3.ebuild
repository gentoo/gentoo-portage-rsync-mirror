# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Rar/Archive-Rar-1.9.3.ebuild,v 1.5 2008/12/23 08:48:55 robbat2 Exp $

inherit versionator
MODULE_AUTHOR=SMUELLER
MY_P="${PN}-$(delete_version_separator 2)"
inherit perl-module

S=${WORKDIR}/${MY_P}

DESCRIPTION="Archive::Rar - Interface with the rar command"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="dev-lang/perl
	app-arch/rar"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"

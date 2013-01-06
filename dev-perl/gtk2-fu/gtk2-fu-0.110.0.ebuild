# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-fu/gtk2-fu-0.110.0.ebuild,v 1.7 2012/03/31 12:09:03 armin76 Exp $

EAPI=4

MY_PN=Gtk2Fu
MODULE_AUTHOR=DAMS
MODULE_VERSION=0.11
inherit perl-module

DESCRIPTION="gtk2-fu is a layer on top of perl gtk2, that brings power, simplicity and speed of development"

SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 x86"
IUSE="test"

RDEPEND="dev-perl/gtk2-perl"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/locale-maketext/locale-maketext-1.13-r1.ebuild,v 1.7 2010/11/13 14:34:34 armin76 Exp $

EAPI=3

MY_PN=Locale-Maketext
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=FERREIRA

inherit perl-module

DESCRIPTION="Localization framework for Perl programs"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc s390 sh sparc x86"
IUSE=""

DEPEND=">=virtual/perl-i18n-langtags-0.30"

SRC_TEST="do"
PATCHES=( "${FILESDIR}"/1.13-defined.patch )

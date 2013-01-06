# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/locale-maketext/locale-maketext-1.190.0.ebuild,v 1.7 2012/02/02 19:21:32 ranger Exp $

EAPI=4

MY_PN=Locale-Maketext
MODULE_AUTHOR=TODDR
MODULE_VERSION=1.19
inherit perl-module

DESCRIPTION="Localization framework for Perl programs"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc s390 sh sparc x86"
IUSE=""

RDEPEND=">=virtual/perl-i18n-langtags-0.31"
DEPEND="${RDEPEND}"

SRC_TEST="do"

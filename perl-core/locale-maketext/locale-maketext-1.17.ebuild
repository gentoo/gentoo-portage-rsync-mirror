# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/locale-maketext/locale-maketext-1.17.ebuild,v 1.1 2010/10/21 08:39:14 tove Exp $

EAPI=3

MY_PN=Locale-Maketext
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=TODDR

inherit perl-module

DESCRIPTION="Localization framework for Perl programs"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND=">=virtual/perl-i18n-langtags-0.31"
DEPEND="${RDEPEND}"

SRC_TEST="do"

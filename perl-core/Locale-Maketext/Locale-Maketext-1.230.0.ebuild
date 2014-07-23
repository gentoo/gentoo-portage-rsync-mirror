# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Locale-Maketext/Locale-Maketext-1.230.0.ebuild,v 1.1 2014/07/22 23:56:00 dilfridge Exp $

EAPI=4

MY_PN=Locale-Maketext
MODULE_AUTHOR=TODDR
MODULE_VERSION=1.23
inherit perl-module

DESCRIPTION="Localization framework for Perl programs"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc s390 sh sparc x86 ~amd64-fbsd"
IUSE=""

RDEPEND=">=virtual/perl-I18N-LangTags-0.31"
DEPEND="${RDEPEND}"

SRC_TEST="do"

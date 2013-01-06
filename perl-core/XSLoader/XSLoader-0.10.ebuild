# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/XSLoader/XSLoader-0.10.ebuild,v 1.6 2010/12/07 04:58:30 mattst88 Exp $

EAPI=2

MODULE_AUTHOR=SAPER
inherit perl-module

DESCRIPTION="Dynamically load C libraries into Perl code"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

PATCHES=( "${FILESDIR}"/91152fc1_rt54132_version081.patch )
SRC_TEST=do

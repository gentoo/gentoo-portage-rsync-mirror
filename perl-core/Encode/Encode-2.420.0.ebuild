# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Encode/Encode-2.420.0.ebuild,v 1.5 2011/06/15 06:16:16 naota Exp $

EAPI=3

MODULE_AUTHOR=DANKOGAI
MODULE_VERSION=2.42
inherit perl-module

DESCRIPTION="character encodings"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

RDEPEND="!!<dev-lang/perl-5.8.8-r8"

SRC_TEST=do
PATCHES=( "${FILESDIR}"/gentoo_enc2xs.diff )

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Params-Check/Params-Check-0.300.0.ebuild,v 1.1 2011/07/26 12:28:24 tove Exp $

EAPI=4

MODULE_AUTHOR=BINGOS
MODULE_VERSION=0.30
inherit perl-module

DESCRIPTION="A generic input parsing/checking mechanism"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="virtual/perl-Locale-Maketext-Simple"
DEPEND="${RDEPEND}"

SRC_TEST=do

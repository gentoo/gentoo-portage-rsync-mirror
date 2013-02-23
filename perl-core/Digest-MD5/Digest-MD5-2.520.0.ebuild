# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Digest-MD5/Digest-MD5-2.520.0.ebuild,v 1.12 2013/02/23 08:32:50 ago Exp $

EAPI=4

MODULE_AUTHOR=GAAS
MODULE_VERSION=2.52
inherit perl-module

DESCRIPTION="MD5 message digest algorithm"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 s390 ~sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="virtual/perl-digest-base"
DEPEND="${RDEPEND}"

SRC_TEST=do
mydoc="rfc*.txt"

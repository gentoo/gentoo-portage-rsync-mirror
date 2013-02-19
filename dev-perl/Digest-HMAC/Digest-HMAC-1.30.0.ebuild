# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-HMAC/Digest-HMAC-1.30.0.ebuild,v 1.13 2013/02/19 01:59:10 zmedico Exp $

EAPI=4

MODULE_AUTHOR=GAAS
MODULE_VERSION=1.03
inherit perl-module

DESCRIPTION="Keyed Hashing for Message Authentication"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="virtual/perl-Digest-MD5
	virtual/perl-Digest-SHA"
DEPEND="${RDEPEND}"

SRC_TEST="do"

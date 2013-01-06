# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Term-ANSIColor/Term-ANSIColor-3.0.0.ebuild,v 1.1 2011/05/19 19:04:45 tove Exp $

EAPI=3

MY_PN="ANSIColor"
MODULE_AUTHOR=RRA
MODULE_VERSION=3.00
inherit perl-module

DESCRIPTION="Color screen output using ANSI escape sequences."

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"

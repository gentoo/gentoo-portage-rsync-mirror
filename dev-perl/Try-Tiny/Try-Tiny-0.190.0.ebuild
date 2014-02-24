# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Try-Tiny/Try-Tiny-0.190.0.ebuild,v 1.3 2014/02/24 17:16:53 zlogene Exp $

EAPI=5

MODULE_AUTHOR=DOY
MODULE_VERSION=0.19
inherit perl-module

DESCRIPTION="Minimal try/catch with proper localization of $@"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~ppc-aix ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="test"

DEPEND="
	test? (
		dev-perl/Sub-Name
		dev-perl/Capture-Tiny
	)
"

SRC_TEST=do

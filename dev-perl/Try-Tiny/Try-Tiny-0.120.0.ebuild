# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Try-Tiny/Try-Tiny-0.120.0.ebuild,v 1.12 2013/04/02 13:23:07 ago Exp $

EAPI=5

MODULE_AUTHOR=DOY
MODULE_VERSION=0.12
inherit perl-module

DESCRIPTION="Minimal try/catch with proper localization of $@"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~ppc-aix ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

SRC_TEST=do

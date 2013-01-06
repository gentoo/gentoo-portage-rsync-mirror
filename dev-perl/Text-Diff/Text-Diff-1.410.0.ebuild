# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Diff/Text-Diff-1.410.0.ebuild,v 1.9 2012/11/23 13:15:01 blueness Exp $

EAPI=4

MODULE_AUTHOR=OVID
MODULE_VERSION=1.41
inherit perl-module

DESCRIPTION="Easily create test classes in an xUnit style."

SLOT="0"
KEYWORDS="amd64 ~arm hppa ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="dev-perl/Algorithm-Diff"
DEPEND="${RDEPEND}"

SRC_TEST=do

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Random-Source/Crypt-Random-Source-0.70.0.ebuild,v 1.2 2011/09/03 21:05:28 tove Exp $

EAPI=4

MODULE_AUTHOR=NUFFIN
MODULE_VERSION=0.07
inherit perl-module

DESCRIPTION="Get weak or strong random data from pluggable sources"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="
	>=dev-perl/Any-Moose-0.11
	>=dev-perl/Capture-Tiny-0.08
	dev-perl/Module-Find
	dev-perl/Sub-Exporter
	>=dev-perl/namespace-clean-0.08
"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Exception
		dev-perl/Test-use-ok
	)"

SRC_TEST="do"

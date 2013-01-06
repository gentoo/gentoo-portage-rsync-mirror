# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Manifest/Test-Manifest-1.230.0.ebuild,v 1.8 2012/03/31 13:38:54 klausman Exp $

EAPI=4

MODULE_AUTHOR=BDFOY
MODULE_VERSION=1.23
inherit perl-module

DESCRIPTION="Interact with a t/test_manifest file"

SLOT="0"
KEYWORDS="alpha amd64 ~arm ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"

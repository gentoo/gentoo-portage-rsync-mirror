# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/String-Tokenizer/String-Tokenizer-0.50.0.ebuild,v 1.1 2011/08/28 19:11:14 tove Exp $

EAPI=4

MODULE_AUTHOR=STEVAN
MODULE_VERSION=0.05
inherit perl-module

DESCRIPTION="A simple string tokenizer"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST=do

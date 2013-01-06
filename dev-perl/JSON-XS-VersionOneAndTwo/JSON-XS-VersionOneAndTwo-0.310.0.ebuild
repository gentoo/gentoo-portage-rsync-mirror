# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JSON-XS-VersionOneAndTwo/JSON-XS-VersionOneAndTwo-0.310.0.ebuild,v 1.1 2011/08/30 11:36:58 tove Exp $

EAPI=4

MODULE_AUTHOR=LBROCARD
MODULE_VERSION=0.31
inherit perl-module

DESCRIPTION="Support versions 1 and 2 of JSON::XS"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/JSON-XS"
DEPEND="
	test? (
		${RDEPEND}
		dev-perl/Test-Pod
	)"

SRC_TEST=do

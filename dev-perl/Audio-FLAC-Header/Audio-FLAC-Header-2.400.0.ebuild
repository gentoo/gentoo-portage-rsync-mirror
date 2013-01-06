# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-FLAC-Header/Audio-FLAC-Header-2.400.0.ebuild,v 1.4 2012/09/12 08:23:28 ssuominen Exp $

EAPI=4

MODULE_AUTHOR=DANIEL
MODULE_VERSION=2.4
inherit perl-module

DESCRIPTION="Access to FLAC audio metadata"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="test"

RDEPEND="media-libs/flac"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"

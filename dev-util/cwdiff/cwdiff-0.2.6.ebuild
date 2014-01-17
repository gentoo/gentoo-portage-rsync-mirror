# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cwdiff/cwdiff-0.2.6.ebuild,v 1.1 2014/01/17 17:53:02 ottxor Exp $

EAPI=5

DESCRIPTION="A script that wraps wdiff to support directories and colorize the output"
HOMEPAGE="http://code.google.com/p/cj-overlay/source/browse/cwdiff?repo=evergreens"
SRC_URI="http://cj-overlay.googlecode.com/files/${P}.tar.gz"
RESTRICT="primaryuri"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-macos"
IUSE="a2ps mercurial"

DEPEND=""
RDEPEND="
	sys-apps/sed
	app-shells/bash
	app-text/wdiff
	sys-apps/diffutils
	a2ps? ( app-text/a2ps )
	mercurial? ( dev-vcs/mercurial )
	"

src_install () {
	dobin "${PN}"
	if use mercurial ; then
		insinto /etc/mercurial/hgrc.d
		doins hgrc.d/"${PN}".rc
	fi
}

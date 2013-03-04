# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/youtube-dl/youtube-dl-2013.01.28.ebuild,v 1.3 2013/03/04 11:23:25 jer Exp $

EAPI=5
PYTHON_COMPAT=(python{2_5,2_6,2_7})

inherit bash-completion-r1 eutils python-single-r1

DESCRIPTION="Download videos from YouTube.com (and mores sites...)"
HOMEPAGE="http://rg3.github.com/youtube-dl/"
SRC_URI="http://youtube-dl.org/downloads/${PV}/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="offensive test"

DEPEND="test? ( dev-python/nose[coverage(+)] )"

S="${WORKDIR}/${PN}"

src_prepare() {
	use offensive || epatch "${FILESDIR}"/${PN}-2013.01.13-offensive.patch
}

src_install() {
	rm -vf youtube_dl/*.py[co]
	python_domodule youtube_dl
	dobin bin/${PN}
	dodoc CHANGELOG README.txt
	doman ${PN}.1
	dobashcomp ${PN}.bash-completion ${PN}
	python_fix_shebang "${ED}"
}

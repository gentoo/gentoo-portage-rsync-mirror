# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/youtube-dl/youtube-dl-2012.12.11.ebuild,v 1.2 2012/12/30 17:05:09 jer Exp $

EAPI="5"
PYTHON_COMPAT=(python{2_5,2_6,2_7})

inherit bash-completion-r1 python-single-r1

DESCRIPTION="A small command-line program to download videos from YouTube."
HOMEPAGE="http://rg3.github.com/youtube-dl/"
# We get the tarball from https://github.com/rg3/${PN}/archive/${PV}.tar.gz
# and then delete the windows exe from it to reduce the download size by 98%,
# and generate the man page, README.txt, and the bash-completion file
SRC_URI="mirror://gentoo/${P}.tar.xz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="test"

# Note: tests need internet access
DEPEND="
	app-arch/xz-utils
	app-arch/zip
	test? ( dev-python/nose )
"

src_prepare() {
	sed -i -e 's/nosetests2/nosetests/' Makefile || die
}

src_install() {
	rm -vf youtube_dl/*.py[co]
	python_domodule youtube_dl
	dobin bin/${PN}
	dodoc README.txt
	doman ${PN}.1
	dobashcomp ${PN}.bash-completion ${PN}
}

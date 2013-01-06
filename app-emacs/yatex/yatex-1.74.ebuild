# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/yatex/yatex-1.74.ebuild,v 1.6 2012/10/14 18:50:40 armin76 Exp $

inherit elisp eutils

DESCRIPTION="Yet Another TeX mode for Emacs"
HOMEPAGE="http://www.yatex.org/"
SRC_URI="http://www.yatex.org/${P/-/}.tar.gz"

KEYWORDS="amd64 ppc ~ppc64 x86"
SLOT="0"
LICENSE="YaTeX"
IUSE="linguas_ja"

S=${WORKDIR}/${P/-/}
SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.73-gentoo.patch"
}

src_compile() {
	# byte-compilation fails (as of 1.74): yatexlib.el requires fonts
	# that are only available under X

	cd docs
	mv yatexe yatex.info
	mv yahtmle yahtml.info
	if use linguas_ja; then
		iconv -f ISO-2022-JP -t EUC-JP yatexj > yatex-ja.info
		iconv -f ISO-2022-JP -t EUC-JP yahtmlj > yahtml-ja.info
	fi
}

src_install() {
	elisp-install ${PN} *.el || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

	insinto ${SITEETC}/${PN}
	doins help/YATEXHLP.eng || die "doins failed"

	doinfo docs/*.info || die "doinfo failed"
	dodoc docs/*.eng || die "dodoc failed"

	if use linguas_ja; then
		doins help/YATEXHLP.jp || die "doins failed"
		dodoc 00readme install docs/{htmlqa,qanda} docs/*.doc \
			|| die "dodoc failed"
	fi
}

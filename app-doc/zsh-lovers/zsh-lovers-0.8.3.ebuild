# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/zsh-lovers/zsh-lovers-0.8.3.ebuild,v 1.10 2014/05/25 11:16:41 ulm Exp $

EAPI=4

DESCRIPTION="Tips, tricks and examples for the Z shell"
HOMEPAGE="http://grml.org/zsh/zsh-lovers.html"
SRC_URI="http://deb.grml.org/pool/main/z/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2 all-rights-reserved"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="
	!<app-shells/zsh-4.3.12
"
DEPEND="${RDEPEND}
	app-text/asciidoc
"

S=${WORKDIR}/${PN}

src_prepare() {
	asciidoc zsh-lovers.1.txt || die
	mv zsh-lovers.1.html zsh-lovers.html || die
	a2x -f manpage zsh-lovers.1.txt || die
	#a2x -f pdf zsh-lovers.1.txt || die
	#mv zsh-lovers.1.pdf zsh-lovers.pdf || die
}

src_install() {
	doman  zsh-lovers.1
	dohtml zsh-lovers.html
	docinto zsh-lovers
	dodoc zsh.vim README
	insinto /usr/share/doc/${PF}/zsh-lovers
	doins refcard.pdf
#	doins zsh-lovers.{ps,pdf} refcard.{dvi,ps,pdf}
	doins -r zsh_people
}

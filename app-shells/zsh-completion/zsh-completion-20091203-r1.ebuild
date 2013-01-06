# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh-completion/zsh-completion-20091203-r1.ebuild,v 1.5 2012/06/04 22:17:40 alexxy Exp $

MY_PV="20080310"
DESCRIPTION="Programmable Completion for zsh (includes emerge and ebuild commands)"
HOMEPAGE="http://gentoo.org"
SRC_URI="mirror://gentoo/${PN}-${MY_PV}.tar.bz2"

LICENSE="ZSH"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc64-solaris"
IUSE=""

DEPEND=">=app-shells/zsh-4.3.5"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm _eix
}

src_install() {
	insinto /usr/share/zsh/site-functions
	doins _*

	dodoc AUTHORS
}

pkg_postinst() {
	elog
	elog "If you happen to compile your functions, you may need to delete"
	elog "~/.zcompdump{,.zwc} and recompile to make zsh-completion available"
	elog "to your shell."
	elog
}

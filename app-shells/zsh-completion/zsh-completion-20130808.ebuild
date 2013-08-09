# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh-completion/zsh-completion-20130808.ebuild,v 1.1 2013/08/08 23:05:06 radhermit Exp $

EAPI=5

DESCRIPTION="Programmable Completion for zsh (includes emerge and ebuild commands)"
HOMEPAGE="http://git.overlays.gentoo.org/gitweb/?p=proj/zsh-completion.git"
SRC_URI="http://dev.gentoo.org/~radhermit/dist/${P}.tar.bz2"

LICENSE="ZSH"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc64-solaris"

RDEPEND=">=app-shells/zsh-4.3.5"

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

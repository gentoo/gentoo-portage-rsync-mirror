# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/fricas/fricas-1.1.8.ebuild,v 1.1 2012/09/18 15:32:40 grozin Exp $
EAPI=4
inherit eutils multilib elisp-common autotools

DESCRIPTION="FriCAS is a fork of Axiom computer algebra system"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-full.tar.bz2"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# Supported lisps, number 0 is the default
LISPS=( sbcl cmucl     gcl ecl    clisp clozurecl )
# . means just dev-lisp/${LISP}; foo-x.y.z means >=dev-lisp/foo-x.y.z
DEPS=(  .    cmucl-20b .   ecls-9 .     .         )
# command name: . means just ${LISP}
COMS=(  .    lisp      .   .      .     ccl       )

IUSE="${LISPS[*]} X emacs gmp"
RDEPEND="X? ( x11-libs/libXpm x11-libs/libICE )
	emacs? ( virtual/emacs )
	gmp? ( dev-libs/gmp )"

# Generating lisp deps
n=${#LISPS[*]}
for ((n--; n > 0; n--)); do
	LISP=${LISPS[$n]}
	DEP=${DEPS[$n]}
	if [ "${DEP}" = "." ]; then
		DEP="dev-lisp/${LISP}"
	else
		DEP=">=dev-lisp/${DEP}"
	fi
	RDEPEND="${RDEPEND} ${LISP}? ( ${DEP} ) !${LISP}? ("
done
RDEPEND="${RDEPEND} dev-lisp/${LISPS[0]}"
n=${#LISPS[*]}
for ((n--; n > 0; n--)); do
	RDEPEND="${RDEPEND} )"
done

DEPEND="${RDEPEND}"

# necessary for clisp and gcl
RESTRICT="strip"

src_prepare() {
	# workaround for broken sbcl
	epatch "${FILESDIR}"/${PN}-sbcl.patch
	eautoreconf
}

src_configure() {
	local LISP n
	LISP=sbcl
	n=${#LISPS[*]}
	for ((n--; n > 0; n--)); do
		if use ${LISPS[$n]}; then
			LISP=${COMS[$n]}
			if [ "${LISP}" = "." ]; then
				LISP=${LISPS[$n]}
			fi
		fi
	done
	einfo "Using lisp: ${LISP}"

	# aldor is not yet in portage
	econf --disable-aldor --with-lisp=${LISP} $(use_with X x) $(use_with gmp)
}

src_compile() {
	# bug #300132
	emake -j1
}

src_test() {
	emake -j1 all-input
}

src_install() {
	emake -j1 DESTDIR="${D}" install
	dodoc README FAQ

	if use emacs; then
		sed -e "s|(setq load-path (cons (quote \"/usr/$(get_libdir)/fricas/emacs\") load-path)) ||" \
			-i "${D}"/usr/bin/efricas \
			|| die "sed efricas failed"
		elisp-install ${PN} "${D}"/usr/$(get_libdir)/${PN}/emacs/*.el
		elisp-site-file-install "${FILESDIR}"/64${PN}-gentoo.el
	else
		rm "${D}"/usr/bin/efricas || die "rm efricas failed"
	fi
	rm -r "${D}"/usr/$(get_libdir)/${PN}/emacs || die "rm -r emacs failed"
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}

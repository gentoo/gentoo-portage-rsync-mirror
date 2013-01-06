# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mosh/mosh-1.2.3.ebuild,v 1.5 2012/12/16 16:27:02 ago Exp $

EAPI=4

inherit autotools vcs-snapshot

DESCRIPTION="Mobile shell that supports roaming and intelligent local echo"
HOMEPAGE="http://mosh.mit.edu"
SRC_URI="https://github.com/keithw/${PN}/tarball/${P} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~mips ppc x86"
IUSE="bash-completion +client examples +mosh-hardening +server ufw +utempter"
REQUIRED_USE="|| ( client server )
	examples? ( client )"

RDEPEND="dev-libs/protobuf
	sys-libs/ncurses:5
	virtual/ssh
	client? ( dev-lang/perl
		dev-perl/IO-Tty )
	utempter? ( sys-libs/libutempter )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable test tests) \
		$(use_enable bash-completion completion) \
		$(use_enable client) \
		$(use_enable server) \
		$(use_enable examples) \
		$(use_enable ufw) \
		$(use_enable mosh-hardening hardening) \
		$(use_with utempter)
}

src_compile() {
	emake V=1
}

src_test() {
	einfo "running test encrypt-decrypt"
	./src/tests/encrypt-decrypt -q || die
	einfo "running test ocb-aes"
	./src/tests/ocb-aes -q || die
}

src_install() {
	default

	for myprog in $(find src/examples -type f -perm /0111) ; do
		newbin ${myprog} ${PN}-$(basename ${myprog})
		elog "${myprog} installed as ${PN}-$(basename ${myprog})"
	done

	if use bash-completion ; then
		insinto /usr/share/bash-completion
		doins "${D}"/etc/bash_completion.d/mosh
		rm -rf "${D}"/etc/bash_completion.d
	fi
}

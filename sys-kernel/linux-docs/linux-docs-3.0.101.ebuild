# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-docs/linux-docs-3.0.101.ebuild,v 1.1 2013/10/31 12:23:09 mpagano Exp $

inherit toolchain-funcs

MY_P=linux-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Developer documentation generated from the Linux kernel"
HOMEPAGE="http://www.kernel.org/"
SRC_URI="mirror://kernel/linux/kernel/v3.x/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"

IUSE="html"
DEPEND="app-text/docbook-sgml-utils
		app-text/xmlto
		sys-apps/sed
		~app-text/docbook-xml-dtd-4.1.2"
RDEPEND=""

src_unpack() {
	unpack ${A}

	sed -i \
		-e "s:db2:docbook2:g" \
		-e "s:/usr/local/man:${D}/usr/share/man:g" \
		"${S}"/Documentation/DocBook/Makefile

	# fix for parallel build as per bug #248337
	sed -i \
		-e "s:\$(Q)\$(MAKE) \$(build)=Documentation\/DocBook \$@:+\$(Q)\$(MAKE) \$(build)=Documentation\/DocBook \$@:" \
		"${S}"/Makefile
}

src_compile() {
	local ARCH=$(tc-arch-kernel)
	unset KBUILD_OUTPUT

	emake mandocs || die "make mandocs failed"

	if use html; then
		emake htmldocs || die "make htmldocs failed"
	fi
}

src_install() {
	local file
	local ARCH=$(tc-arch-kernel)
	unset KBUILD_OUTPUT

	make installmandocs || die "make installmandocs failed"

	if use html; then
		for file in Documentation/DocBook/*.html; do
			dohtml -r ${file/\.html/}
		done
	fi
}

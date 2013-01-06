# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby-enterprise/ruby-enterprise-1.8.7.2011.03.ebuild,v 1.1 2011/05/15 17:59:27 graaff Exp $

EAPI=2

inherit autotools eutils flag-o-matic multilib versionator

MY_P="${PN}-$(replace_version_separator 3 '-')"
S="${WORKDIR}/${MY_P}/source"

SLOT=$(get_version_component_range 1-2)
MY_SUFFIX="ee$(delete_version_separator 1 ${SLOT})"
# 1.8 and 1.9 series disagree on this
RUBYVERSION=$(get_version_component_range 1-2)

if [[ -n ${PATCHSET} ]]; then
	if [[ ${PVR} == ${PV} ]]; then
		PATCHSET="${PV}-r0.${PATCHSET}"
	else
		PATCHSET="${PVR}.${PATCHSET}"
	fi
else
	PATCHSET="${PVR}"
fi

DESCRIPTION="Ruby Enterprise Edition is a branch of Ruby including various enhancements"
HOMEPAGE="http://www.rubyenterpriseedition.com/"
SRC_URI="http://rubyenterpriseedition.googlecode.com/files/${MY_P}.tar.gz
		 http://dev.gentoo.org/~flameeyes/ruby-team/${PN}-patches-${PATCHSET}.tar.bz2"

LICENSE="|| ( Ruby GPL-2 )"
KEYWORDS="~amd64 ~x86"
IUSE="+berkdb debug doc examples fastthreading +gdbm ipv6 rubytests ssl tcmalloc threads tk xemacs ncurses +readline libedit"

RDEPEND="
	berkdb? ( sys-libs/db )
	gdbm? ( sys-libs/gdbm )
	ssl? ( >=dev-libs/openssl-0.9.8m )
	tk? ( dev-lang/tk[threads=] )
	ncurses? ( sys-libs/ncurses )
	libedit? ( dev-libs/libedit )
	!libedit? ( readline? ( sys-libs/readline ) )
	sys-libs/zlib
	>=app-admin/eselect-ruby-20100402
	tcmalloc? ( dev-util/google-perftools )"
DEPEND="${RDEPEND}"
# TODO rubygems
PDEPEND="xemacs? ( app-xemacs/ruby-modes )"

src_prepare() {
	EPATCH_FORCE="yes" EPATCH_SUFFIX="patch" \
		epatch "${WORKDIR}/patches"

	if use fastthreading; then
		einfo
		elog "NOTE: The fast threading feature in dev-lang/ruby-enterprise is"
		elog "considered as EXPERIMENTAL. It also disables callcc. Use with care."
		einfo
	else
		einfo "Restoring vanilla threading..."
		EPATCH_OPTS="${EPATCH_OPTS} -R" \
			epatch "${WORKDIR}/patches/999-fast-threading-NOAPPLY.diff" \
			|| die "Reverting the fast-threading patch failed"
	fi

	if use tcmalloc ; then
		sed -i 's:^EXTLIBS.*:EXTLIBS = -ltcmalloc_minimal:' Makefile.in
	fi

	# Fix a hardcoded lib path in configure script
	sed -i -e "s:\(RUBY_LIB_PREFIX=\"\${prefix}/\)lib:\1$(get_libdir):" \
		configure.in || die "sed failed"

	eautoreconf
}

src_configure() {
	local myconf=

	# -fomit-frame-pointer makes ruby segfault, see bug #150413.
	filter-flags -fomit-frame-pointer
	# In many places aliasing rules are broken; play it safe
	# as it's risky with newer compilers to leave it as it is.
	append-flags -fno-strict-aliasing

	# Increase GC_MALLOC_LIMIT if set (default is 8000000)
	if [ -n "${RUBY_GC_MALLOC_LIMIT}" ] ; then
		append-flags "-DGC_MALLOC_LIMIT=${RUBY_GC_MALLOC_LIMIT}"
	fi

	# ipv6 hack, bug 168939. Needs --enable-ipv6.
	use ipv6 || myconf="${myconf} --with-lookup-order-hack=INET"

	if use libedit; then
		einfo "Using libedit to provide readline extension"
		myconf="${myconf} --enable-libedit --with-readline"
	elif use readline; then
		einfo "Using readline to provide readline extension"
		myconf="${myconf} --with-readline"
	else
		myconf="${myconf} --without-readline"
	fi

	econf \
		--program-suffix="${MY_SUFFIX}" \
		--enable-shared \
		$(use_enable doc install-doc) \
		$(use_enable threads pthread) \
		--enable-ipv6 \
		$(use_enable debug) \
		$(use_with berkdb dbm) \
		$(use_with gdbm) \
		$(use_with ssl openssl) \
		$(use_with tk) \
		$(use_with ncurses curses) \
		${myconf} \
		--with-sitedir=/usr/$(get_libdir)/rubyee/site_ruby \
		--with-vendordir=/usr/$(get_libdir)/rubyee/vendor_ruby \
		--enable-option-checking=no \
		|| die "econf failed"
}

src_compile() {
	emake EXTLDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_test() {
	emake -j1 test || die "make test failed"

	elog "Ruby's make test has been run. Ruby also ships with a make check"
	elog "that cannot be run until after ruby has been installed."
	elog
	if use rubytests; then
		elog "You have enabled rubytests, so they will be installed to"
		elog "/usr/share/${PN}-${SLOT}/test. To run them you must be a user other"
		elog "than root, and you must place them into a writeable directory."
		elog "Then call: "
		elog
		elog "ruby${MY_SUFFIX} -C /location/of/tests runner.rb"
	else
		elog "Enable the rubytests USE flag to install the make check tests"
	fi
}

src_install() {
	# Ruby is involved in the install process, we don't want interference here.
	unset RUBYOPT

	local MINIRUBY=$(echo -e 'include Makefile\ngetminiruby:\n\t@echo $(MINIRUBY)'|make -f - getminiruby)

	LD_LIBRARY_PATH="${D}/usr/$(get_libdir)${LD_LIBRARY_PATH+:}${LD_LIBRARY_PATH}"
	RUBYLIB="${S}:${D}/usr/$(get_libdir)/rubyee/${RUBYVERSION}"
	for d in $(find "${S}/ext" -type d) ; do
		RUBYLIB="${RUBYLIB}:$d"
	done
	export LD_LIBRARY_PATH RUBYLIB

	emake DESTDIR="${D}" install || die "make install failed"

	keepdir $(${MINIRUBY} -rrbconfig -e "print Config::CONFIG['sitelibdir']")
	keepdir $(${MINIRUBY} -rrbconfig -e "print Config::CONFIG['sitearchdir']")

	if use doc; then
		make DESTDIR="${D}" install-doc || die "make install-doc failed"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r sample
	fi

	dodoc ChangeLog NEWS README* ToDo || die

	if use rubytests; then
		pushd test
		insinto /usr/share/${PN}-${SLOT}/test
		doins -r .
		popd
	fi
}

pkg_postinst() {
	if [[ ! -n $(readlink "${ROOT}"usr/bin/ruby) ]] ; then
		eselect ruby set ruby${MY_SUFFIX}
	fi

	ewarn
	ewarn "Ruby Enterprise Edition is not guaranteed to be binary-compatible to"
	ewarn "MRI (dev-lang/ruby). Exercise care especially with C extensions!"
	ewarn "Gentoo does *not* accept any bugs regarding such failures."
	ewarn

	elog
	elog "To switch between available Ruby profiles, execute as root:"
	elog "\teselect ruby set ruby(18|19|...)"
	elog
}

pkg_postrm() {
	eselect ruby cleanup
}

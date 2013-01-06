# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gearmand/gearmand-0.33.ebuild,v 1.2 2012/06/21 14:43:30 flameeyes Exp $

EAPI=4

inherit flag-o-matic libtool

DESCRIPTION="Generic framework to farm out work to other machines"
HOMEPAGE="http://www.gearman.org/"
SRC_URI="http://launchpad.net/gearmand/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug tcmalloc +memcache drizzle sqlite tokyocabinet postgres"

RDEPEND="dev-libs/libevent
	|| ( >=sys-apps/util-linux-2.16 <sys-libs/e2fsprogs-libs-1.41.8 )
	tcmalloc? ( dev-util/google-perftools )
	memcache? ( >=dev-libs/libmemcached-0.47 )
	drizzle? ( dev-db/drizzle )
	sqlite? ( dev-db/sqlite:3 )
	tokyocabinet? ( dev-db/tokyocabinet )
	postgres? ( >=dev-db/postgresql-base-9.0 )"
DEPEND="${RDEPEND}"

pkg_setup() {
	enewuser gearmand -1 -1 /dev/null nogroup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}+gcc-4.7.patch
	elibtoolize
}

src_configure() {
	# Don't ever use --enable-assert since configure.ac is broken, and
	# only does --disable-assert correctly.
	 if use debug; then
		# Since --with-debug would turn off optimisations as well as
		# enabling debug, we just enable debug through the
		# preprocessor then.
		append-flags -DDEBUG
	else
		myconf="${myconf} --disable-assert"
	fi

	econf \
		--disable-static \
		--disable-dependency-tracking \
		--disable-mtmalloc \
		$(use_enable tcmalloc) \
		$(use_enable memcache libmemcached) \
		$(use_enable drizzle libdrizzle) \
		$(use_enable sqlite libsqlite3) \
		$(use_enable tokyocabinet libtokyocabinet) \
		$(use_enable postgres libpq)
}

src_test() {
	# Since libtool is stupid and doesn't discard /usr/lib64 from the
	# load path, we'd end up testing against the installed copy of
	# gearmand (bad).
	#
	# We thus cheat and "fix" the scripts by hand.
	sed -i -e '/LD_LIBRARY_PATH=/s|/usr/lib64:||' "${S}"/tests/*_test \
		|| die "test fixing failed"

	emake check
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc README AUTHORS ChangeLog

	newinitd "${FILESDIR}"/gearmand.init.d.2 gearmand
	newconfd "${FILESDIR}"/gearmand.conf.d gearmand

	find "${D}" -name '*.la' -delete || die
}

pkg_postinst() {
	elog ""
	elog "Unless you set the PERSISTENT_TABLE option in"
	elog "/etc/conf.d/gearmand, Gearmand will use table 'queue'."
	elog "If such table doesn't exist, Gearmand will create it for you"
	elog ""
}

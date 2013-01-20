# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/nginx/nginx-1.2.6-r1.ebuild,v 1.3 2013/01/20 19:57:10 ago Exp $

EAPI="4"

# Maintainer notes:
# - http_rewrite-independent pcre-support makes sense for matching locations without an actual rewrite
# - any http-module activates the main http-functionality and overrides USE=-http
# - keep the following requirements in mind before adding external modules:
#   * alive upstream
#   * sane packaging
#   * builds cleanly
#   * does not need a patch for nginx core
# - TODO: test the google-perftools module (included in vanilla tarball)

# prevent perl-module from adding automagic perl DEPENDs
GENTOO_DEPEND_ON_PERL="no"

# syslog
SYSLOG_MODULE_PV="0.24"
SYSLOG_MODULE_NGINX_PV="1.2.0"
SYSLOG_MODULE_P="ngx_syslog-${SYSLOG_MODULE_PV}"
SYSLOG_MODULE_URI="https://github.com/yaoweibin/nginx_syslog_patch/archive/v${SYSLOG_MODULE_PV}.tar.gz"
SYSLOG_MODULE_WD="${WORKDIR}/nginx_syslog_patch-${SYSLOG_MODULE_PV}"

# devel_kit (https://github.com/simpl/ngx_devel_kit, BSD license)
DEVEL_KIT_MODULE_PV="0.2.17"
DEVEL_KIT_MODULE_P="ngx_devel_kit-${DEVEL_KIT_MODULE_PV}-r1"
DEVEL_KIT_MODULE_URI="https://github.com/simpl/ngx_devel_kit/archive/v${DEVEL_KIT_MODULE_PV}.tar.gz"
DEVEL_KIT_MODULE_WD="${WORKDIR}/ngx_devel_kit-${DEVEL_KIT_MODULE_PV}"

# http_uploadprogress (https://github.com/masterzen/nginx-upload-progress-module, BSD-2 license)
HTTP_UPLOAD_PROGRESS_MODULE_PV="0.9.0"
HTTP_UPLOAD_PROGRESS_MODULE_P="ngx_http_upload_progress-${HTTP_UPLOAD_PROGRESS_MODULE_PV}-r1"
HTTP_UPLOAD_PROGRESS_MODULE_URI="https://github.com/masterzen/nginx-upload-progress-module/archive/v${HTTP_UPLOAD_PROGRESS_MODULE_PV}.tar.gz"
HTTP_UPLOAD_PROGRESS_MODULE_WD="${WORKDIR}/nginx-upload-progress-module-${HTTP_UPLOAD_PROGRESS_MODULE_PV}"

# http_headers_more (http://github.com/agentzh/headers-more-nginx-module, BSD license)
HTTP_HEADERS_MORE_MODULE_PV="0.19"
HTTP_HEADERS_MORE_MODULE_P="ngx_http_headers_more-${HTTP_HEADERS_MORE_MODULE_PV}-r1"
HTTP_HEADERS_MORE_MODULE_URI="https://github.com/agentzh/headers-more-nginx-module/archive/v${HTTP_HEADERS_MORE_MODULE_PV}.tar.gz"
HTTP_HEADERS_MORE_MODULE_WD="${WORKDIR}/headers-more-nginx-module-${HTTP_HEADERS_MORE_MODULE_PV}"

# http_push (http://pushmodule.slact.net/, MIT license)
HTTP_PUSH_MODULE_PV="0.692"
HTTP_PUSH_MODULE_P="ngx_http_push-${HTTP_PUSH_MODULE_PV}"
HTTP_PUSH_MODULE_URI="http://pushmodule.slact.net/downloads/nginx_http_push_module-${HTTP_PUSH_MODULE_PV}.tar.gz"
HTTP_PUSH_MODULE_WD="${WORKDIR}/nginx_http_push_module-${HTTP_PUSH_MODULE_PV}"

# http_cache_purge (http://labs.frickle.com/nginx_ngx_cache_purge/, BSD-2 license)
HTTP_CACHE_PURGE_MODULE_PV="2.0"
HTTP_CACHE_PURGE_MODULE_P="ngx_http_cache_purge-${HTTP_CACHE_PURGE_MODULE_PV}"
HTTP_CACHE_PURGE_MODULE_URI="http://labs.frickle.com/files/ngx_cache_purge-${HTTP_CACHE_PURGE_MODULE_PV}.tar.gz"
HTTP_CACHE_PURGE_MODULE_WD="${WORKDIR}/ngx_cache_purge-${HTTP_CACHE_PURGE_MODULE_PV}"

# http_upload (http://www.grid.net.ru/nginx/upload.en.html, BSD license)
HTTP_UPLOAD_MODULE_PV="2.2.0"
HTTP_UPLOAD_MODULE_P="ngx_http_upload-${HTTP_UPLOAD_MODULE_PV}"
HTTP_UPLOAD_MODULE_URI="http://www.grid.net.ru/nginx/download/nginx_upload_module-${HTTP_UPLOAD_MODULE_PV}.tar.gz"
HTTP_UPLOAD_MODULE_WD="${WORKDIR}/nginx_upload_module-${HTTP_UPLOAD_MODULE_PV}"

# http_slowfs_cache (http://labs.frickle.com/nginx_ngx_slowfs_cache/, BSD-2 license)
HTTP_SLOWFS_CACHE_MODULE_PV="1.9"
HTTP_SLOWFS_CACHE_MODULE_P="ngx_http_slowfs_cache-${HTTP_SLOWFS_CACHE_MODULE_PV}"
HTTP_SLOWFS_CACHE_MODULE_URI="http://labs.frickle.com/files/ngx_slowfs_cache-${HTTP_SLOWFS_CACHE_MODULE_PV}.tar.gz"
HTTP_SLOWFS_CACHE_MODULE_WD="${WORKDIR}/ngx_slowfs_cache-${HTTP_SLOWFS_CACHE_MODULE_PV}"

# http_fancyindex (http://wiki.nginx.org/NgxFancyIndex, BSD license)
HTTP_FANCYINDEX_MODULE_PV="0.3.1.1"
HTTP_FANCYINDEX_MODULE_P="ngx_http_fancyindex-${HTTP_FANCYINDEX_MODULE_PV}"
HTTP_FANCYINDEX_MODULE_URI="http://gitorious.org/ngx-fancyindex/ngx-fancyindex/archive-tarball/2034d0ad"
HTTP_FANCYINDEX_MODULE_WD="${WORKDIR}/ngx-fancyindex-ngx-fancyindex"

# http_lua (https://github.com/chaoslawful/lua-nginx-module, BSD license)
HTTP_LUA_MODULE_PV="0.7.11"
HTTP_LUA_MODULE_P="ngx_http_lua-${HTTP_LUA_MODULE_PV}"
HTTP_LUA_MODULE_URI="https://github.com/chaoslawful/lua-nginx-module/archive/v${HTTP_LUA_MODULE_PV}.tar.gz"
HTTP_LUA_MODULE_WD="${WORKDIR}/lua-nginx-module-${HTTP_LUA_MODULE_PV}"

# http_auth_pam (http://web.iti.upv.es/~sto/nginx/, unknown license)
HTTP_AUTH_PAM_MODULE_PV="1.2"
HTTP_AUTH_PAM_MODULE_P="ngx_http_auth_pam-${HTTP_AUTH_PAM_MODULE_PV}"
HTTP_AUTH_PAM_MODULE_URI="http://web.iti.upv.es/~sto/nginx/ngx_http_auth_pam_module-${HTTP_AUTH_PAM_MODULE_PV}.tar.gz"
HTTP_AUTH_PAM_MODULE_WD="${WORKDIR}/ngx_http_auth_pam_module-${HTTP_AUTH_PAM_MODULE_PV}"

inherit eutils ssl-cert toolchain-funcs perl-module flag-o-matic user

DESCRIPTION="Robust, small and high performance http and reverse proxy server"
HOMEPAGE="http://nginx.org"
SRC_URI="http://nginx.org/download/${P}.tar.gz
	syslog? ( ${SYSLOG_MODULE_URI} -> ${SYSLOG_MODULE_P}.tar.gz )
	${DEVEL_KIT_MODULE_URI} -> ${DEVEL_KIT_MODULE_P}.tar.gz
	nginx_modules_http_upload_progress? ( ${HTTP_UPLOAD_PROGRESS_MODULE_URI} -> ${HTTP_UPLOAD_PROGRESS_MODULE_P}.tar.gz )
	nginx_modules_http_headers_more? ( ${HTTP_HEADERS_MORE_MODULE_URI} -> ${HTTP_HEADERS_MORE_MODULE_P}.tar.gz )
	nginx_modules_http_push? ( ${HTTP_PUSH_MODULE_URI} -> ${HTTP_PUSH_MODULE_P}.tar.gz )
	nginx_modules_http_cache_purge? ( ${HTTP_CACHE_PURGE_MODULE_URI} -> ${HTTP_CACHE_PURGE_MODULE_P}.tar.gz )
	nginx_modules_http_upload? ( ${HTTP_UPLOAD_MODULE_URI} -> ${HTTP_UPLOAD_MODULE_P}.tar.gz )
	nginx_modules_http_slowfs_cache? ( ${HTTP_SLOWFS_CACHE_MODULE_URI} -> ${HTTP_SLOWFS_CACHE_MODULE_P}.tar.gz )
	nginx_modules_http_fancyindex? ( ${HTTP_FANCYINDEX_MODULE_URI} -> ${HTTP_FANCYINDEX_MODULE_P}.tar.gz )
	nginx_modules_http_lua? ( ${HTTP_LUA_MODULE_URI} -> ${HTTP_LUA_MODULE_P}.tar.gz )
	nginx_modules_http_auth_pam? ( ${HTTP_AUTH_PAM_MODULE_URI} -> ${HTTP_AUTH_PAM_MODULE_P}.tar.gz )"

LICENSE="BSD-2 BSD SSLeay MIT GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x86-fbsd ~amd64-linux ~x86-linux"

NGINX_MODULES_STD="access auth_basic autoindex browser charset empty_gif fastcgi
geo gzip limit_req limit_conn map memcached proxy referer rewrite scgi ssi
split_clients upstream_ip_hash userid uwsgi"
NGINX_MODULES_OPT="addition dav degradation flv geoip gzip_static image_filter
mp4 perl random_index realip secure_link stub_status sub xslt"
NGINX_MODULES_MAIL="imap pop3 smtp"
NGINX_MODULES_3RD="
	http_upload_progress
	http_headers_more
	http_push
	http_cache_purge
	http_upload
	http_slowfs_cache
	http_fancyindex
	http_lua
	http_auth_pam"

IUSE="aio debug +http +http-cache ipv6 libatomic +pcre pcre-jit selinux ssl
syslog vim-syntax"

for mod in $NGINX_MODULES_STD; do
	IUSE="${IUSE} +nginx_modules_http_${mod}"
done

for mod in $NGINX_MODULES_OPT; do
	IUSE="${IUSE} nginx_modules_http_${mod}"
done

for mod in $NGINX_MODULES_MAIL; do
	IUSE="${IUSE} nginx_modules_mail_${mod}"
done

for mod in $NGINX_MODULES_3RD; do
	IUSE="${IUSE} nginx_modules_${mod}"
done

CDEPEND="
	pcre? ( >=dev-libs/libpcre-4.2 )
	pcre-jit? ( >=dev-libs/libpcre-8.20[jit] )
	selinux? ( sec-policy/selinux-nginx )
	ssl? ( dev-libs/openssl )
	http-cache? ( userland_GNU? ( dev-libs/openssl ) )
	nginx_modules_http_geo? ( dev-libs/geoip )
	nginx_modules_http_gzip? ( sys-libs/zlib )
	nginx_modules_http_gzip_static? ( sys-libs/zlib )
	nginx_modules_http_image_filter? ( media-libs/gd[jpeg,png] )
	nginx_modules_http_perl? ( >=dev-lang/perl-5.8 )
	nginx_modules_http_rewrite? ( >=dev-libs/libpcre-4.2 )
	nginx_modules_http_secure_link? ( userland_GNU? ( dev-libs/openssl ) )
	nginx_modules_http_xslt? ( dev-libs/libxml2 dev-libs/libxslt )
	nginx_modules_http_lua? ( || ( dev-lang/lua dev-lang/luajit ) )
	nginx_modules_http_auth_pam? ( virtual/pam )"
RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}
	arm? ( dev-libs/libatomic_ops )
	libatomic? ( dev-libs/libatomic_ops )"
PDEPEND="vim-syntax? ( app-vim/nginx-syntax )"
REQUIRED_USE="pcre-jit? ( pcre )"

pkg_setup() {
	ebegin "Creating nginx user and group"
	enewgroup ${PN}
	enewuser ${PN} -1 -1 -1 ${PN}
	eend $?

	if use libatomic; then
		ewarn "GCC 4.1+ features built-in atomic operations."
		ewarn "Using libatomic_ops is only needed if using"
		ewarn "a different compiler or a GCC prior to 4.1"
	fi

	if [[ -n $NGINX_ADD_MODULES ]]; then
		ewarn "You are building custom modules via \$NGINX_ADD_MODULES!"
		ewarn "This nginx installation is not supported!"
		ewarn "Make sure you can reproduce the bug without those modules"
		ewarn "_before_ reporting bugs."
	fi

	if use !http; then
		ewarn "To actually disable all http-functionality you also have to disable"
		ewarn "all nginx http modules."
	fi
}

src_prepare() {
	use syslog && epatch "${SYSLOG_MODULE_WD}"/syslog_${SYSLOG_MODULE_NGINX_PV}.patch

	find auto/ -type f -print0 | xargs -0 sed -i 's:\&\& make:\&\& \\$(MAKE):' || die
	# We have config protection, don't rename etc files
	sed -i 's:.default::' auto/install || die
	# remove useless files
	sed -i -e '/koi-/d' -e '/win-/d' auto/install || die
}

src_configure() {
	local myconf= http_enabled= mail_enabled=

	use aio       && myconf+=" --with-file-aio --with-aio_module"
	use debug     && myconf+=" --with-debug"
	use ipv6      && myconf+=" --with-ipv6"
	use libatomic && myconf+=" --with-libatomic"
	use pcre      && myconf+=" --with-pcre"
	use pcre-jit  && myconf+=" --with-pcre-jit"

	# syslog support
	if use syslog; then
		myconf+=" --add-module=${SYSLOG_MODULE_WD}"
	fi

	# HTTP modules
	for mod in $NGINX_MODULES_STD; do
		if use nginx_modules_http_${mod}; then
			http_enabled=1
		else
			myconf+=" --without-http_${mod}_module"
		fi
	done

	for mod in $NGINX_MODULES_OPT; do
		if use nginx_modules_http_${mod}; then
			http_enabled=1
			myconf+=" --with-http_${mod}_module"
		fi
	done

	if use nginx_modules_http_fastcgi; then
		myconf+=" --with-http_realip_module"
	fi

	# third-party modules
	if use nginx_modules_http_upload_progress; then
		http_enabled=1
		myconf+=" --add-module=${HTTP_UPLOAD_PROGRESS_MODULE_WD}"
	fi

	if use nginx_modules_http_headers_more; then
		http_enabled=1
		myconf+=" --add-module=${HTTP_HEADERS_MORE_MODULE_WD}"
	fi

	if use nginx_modules_http_push; then
		http_enabled=1
		myconf+=" --add-module=${HTTP_PUSH_MODULE_WD}"
	fi

	if use nginx_modules_http_cache_purge; then
		http_enabled=1
		myconf+=" --add-module=${HTTP_CACHE_PURGE_MODULE_WD}"
	fi

	if use nginx_modules_http_upload; then
		http_enabled=1
		myconf+=" --add-module=${HTTP_UPLOAD_MODULE_WD}"
	fi

	if use nginx_modules_http_slowfs_cache; then
		http_enabled=1
		myconf+=" --add-module=${HTTP_SLOWFS_CACHE_MODULE_WD}"
	fi

	if use nginx_modules_http_fancyindex; then
		http_enabled=1
		myconf+=" --add-module=${HTTP_FANCYINDEX_MODULE_WD}"
	fi

	if use nginx_modules_http_lua; then
		http_enabled=1
		myconf+=" --add-module=${DEVEL_KIT_MODULE_WD}"
		myconf+=" --add-module=${HTTP_LUA_MODULE_WD}"
	fi

	if use nginx_modules_http_auth_pam; then
		http_enabled=1
		myconf+=" --add-module=${HTTP_AUTH_PAM_MODULE_WD}"
	fi

	if use http || use http-cache; then
		http_enabled=1
	fi

	if [ $http_enabled ]; then
		use http-cache || myconf+=" --without-http-cache"
		use ssl && myconf+=" --with-http_ssl_module"
	else
		myconf+=" --without-http --without-http-cache"
	fi

	# MAIL modules
	for mod in $NGINX_MODULES_MAIL; do
		if use nginx_modules_mail_${mod}; then
			mail_enabled=1
		else
			myconf+=" --without-mail_${mod}_module"
		fi
	done

	if [ $mail_enabled ]; then
		myconf+=" --with-mail"
		use ssl && myconf+=" --with-mail_ssl_module"
	fi

	# custom modules
	for mod in $NGINX_ADD_MODULES; do
		myconf+=" --add-module=${mod}"
	done

	# https://bugs.gentoo.org/286772
	export LANG=C LC_ALL=C
	tc-export CC

	if ! use prefix; then
		myconf+=" --user=${PN} --group=${PN}"
	fi

	./configure \
		--prefix="${EPREFIX}"/usr \
		--conf-path="${EPREFIX}"/etc/${PN}/${PN}.conf \
		--error-log-path="${EPREFIX}"/var/log/${PN}/error_log \
		--pid-path="${EPREFIX}"/var/run/${PN}.pid \
		--lock-path="${EPREFIX}"/var/lock/nginx.lock \
		--with-cc-opt="-I${EROOT}usr/include" \
		--with-ld-opt="-L${EROOT}usr/lib" \
		--http-log-path="${EPREFIX}"/var/log/${PN}/access_log \
		--http-client-body-temp-path="${EPREFIX}"/var/tmp/${PN}/client \
		--http-proxy-temp-path="${EPREFIX}"/var/tmp/${PN}/proxy \
		--http-fastcgi-temp-path="${EPREFIX}"/var/tmp/${PN}/fastcgi \
		--http-scgi-temp-path="${EPREFIX}"/var/tmp/${PN}/scgi \
		--http-uwsgi-temp-path="${EPREFIX}"/var/tmp/${PN}/uwsgi \
		${myconf} || die "configure failed"
}

src_compile() {
	# https://bugs.gentoo.org/286772
	export LANG=C LC_ALL=C
	emake LINK="${CC} ${LDFLAGS}" OTHERLDFLAGS="${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install

	cp "${FILESDIR}"/nginx.conf "${ED}"/etc/nginx/nginx.conf || die

	newinitd "${FILESDIR}"/nginx.initd nginx

	doman man/nginx.8
	dodoc CHANGES* README

	# just keepdir. do not copy the default htdocs files (bug #449136)
	keepdir /var/www/localhost
	rm -rf "${D}"/usr/html || die

	# logrotate
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/nginx.logrotate nginx

	if use nginx_modules_http_perl; then
		cd "${S}"/objs/src/http/modules/perl/
		einstall DESTDIR="${D}" INSTALLDIRS=vendor
		fixlocalpod
	fi

	if use syslog; then
		docinto ${SYSLOG_MODULE_P}
		dodoc "${SYSLOG_MODULE_WD}"/README
	fi

	if use nginx_modules_http_push; then
		docinto ${HTTP_PUSH_MODULE_P}
		dodoc "${HTTP_PUSH_MODULE_WD}"/{changelog.txt,protocol.txt,README}
	fi

	if use nginx_modules_http_cache_purge; then
		docinto ${HTTP_CACHE_PURGE_MODULE_P}
		dodoc "${HTTP_CACHE_PURGE_MODULE_WD}"/{CHANGES,README.md,TODO.md}
	fi

	if use nginx_modules_http_upload; then
		docinto ${HTTP_UPLOAD_MODULE_P}
		dodoc "${HTTP_UPLOAD_MODULE_WD}"/{Changelog,README}
	fi

	if use nginx_modules_http_slowfs_cache; then
		docinto ${HTTP_SLOWFS_CACHE_MODULE_P}
		dodoc "${HTTP_SLOWFS_CACHE_MODULE_WD}"/{CHANGES,README.md}
	fi

	if use nginx_modules_http_fancyindex; then
		docinto ${HTTP_FANCYINDEX_MODULE_P}
		dodoc "${HTTP_FANCYINDEX_MODULE_WD}"/README.rst
	fi

	if use nginx_modules_http_lua; then
		docinto ${HTTP_LUA_MODULE_P}
		dodoc "${HTTP_LUA_MODULE_WD}"/{Changes,README.markdown}
	fi

	if use nginx_modules_http_auth_pam; then
		docinto ${HTTP_AUTH_PAM_MODULE_P}
		dodoc "${HTTP_AUTH_PAM_MODULE_WD}"/{README,ChangeLog}
	fi
}

pkg_postinst() {
	if use ssl; then
		if [ ! -f "${EROOT}"/etc/ssl/${PN}/${PN}.key ]; then
			install_cert /etc/ssl/${PN}/${PN}
			use prefix || chown ${PN}:${PN} "${EROOT}"/etc/ssl/${PN}/${PN}.{crt,csr,key,pem}
		fi
	fi
}

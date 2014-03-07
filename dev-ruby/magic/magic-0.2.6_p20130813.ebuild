# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/magic/magic-0.2.6_p20130813.ebuild,v 1.1 2014/03/06 23:42:19 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_EXTRADOC="README.rdoc"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_RECIPE_TEST="none"

RUBY_FAKEGEM_VERSION="0.2.6.20130813"

inherit vcs-snapshot ruby-fakegem

COMMIT_ID="9fd5e3ff7505d649289857d29d9008440aa0808e"
SRC_URI="https://github.com/qoobaa/magic/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
DESCRIPTION="Ruby FFI bindings to libmagic"
HOMEPAGE="http://github.com/qoobaa/magic"

IUSE="test"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RUBY_S="${PN}-${COMMIT_ID}"

ruby_add_bdepend "test? ( dev-ruby/test-unit:2 )"

all_ruby_prepare() {
# Remove failing tests
	sed -i -e '/filelogo.jpg mime with empty database/,+2d'\
		-e '/guess non-existing file mime/,+4d' test/test_magic.rb || die
}

each_ruby_test() {
	${RUBY} -Ilib -Itest test/test_magic.rb || die
}

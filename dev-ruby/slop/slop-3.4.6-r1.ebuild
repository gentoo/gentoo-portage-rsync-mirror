# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/slop/slop-3.4.6-r1.ebuild,v 1.1 2013/10/09 00:47:52 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGES.md README.md"

inherit ruby-fakegem

DESCRIPTION="A simple option parser with an easy to remember syntax and friendly API."
HOMEPAGE="https://github.com/injekt/slop"
SRC_URI="https://github.com/injekt/${PN}/archive/v${PV}.tar.gz -> ${P}.tgz"

LICENSE="MIT"
SLOT="3"
KEYWORDS="~amd64 ~ppc64 ~x86"

IUSE=""

ruby_add_bdepend "test? ( dev-ruby/minitest )"

all_ruby_prepare() {
	sed -i -e '/git ls-files/d' slop.gemspec || die
}

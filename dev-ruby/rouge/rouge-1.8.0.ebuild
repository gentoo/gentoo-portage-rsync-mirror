# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rouge/rouge-1.8.0.ebuild,v 1.1 2015/02/03 21:56:09 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_EXTRADOC="README.md CHANGELOG.md"
RUBY_FAKEGEM_TASK_TEST="spec"
RUBY_FAKEGEM_RECIPE_DOC="yard"

inherit ruby-fakegem

DESCRIPTION="Yet-another-markdown-parser but fast, pure Ruby, using a strict syntax definition"
HOMEPAGE="http://github.com/jneen/rouge"
SRC_URI="https://github.com/jneen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/redcarpet )"
ruby_add_rdepend "dev-ruby/redcarpet"

RESTRICT="test"
# Depends on dev-ruby/wrong, which is not packaged yet.

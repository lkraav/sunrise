# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

inherit eutils

DESCRIPTION="kerberos-ticket refresher for running services on data in kerberized file systems"
HOMEPAGE="http://www.eyrie.org/~eagle/software/kstart/"
SRC_URI="http://archives.eyrie.org/software/kerberos/kstart-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="afs kerberos krb4"

DEPEND="afs? ( net-fs/openafs )
	kerberos? ( virtual/krb5 )"

RDEPEND="${DEPEND}"

S="${WORKDIR}/kstart-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/kstart-"${PV}"-happy-tickets.patch
}

src_compile() {
	econf \
		$(use_enable krb4 k4start) \
		$(use_with kerberos) \
		$(use_with afs aklog /usr/bin/aklog)
	emake || die "emake failed"
}

src_install() {
	dobin k5start krenew
	if use krb4; then
		dobin k4start
		doman k4start.1
	fi
	doman k5start.1 krenew.1
	dodoc README NEWS
}
